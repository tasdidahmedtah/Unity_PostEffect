// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
	}



	SubShader {
		Pass {
			Tags { "LightMode" = "Always" }
			ZTest Always Cull Off ZWrite Off Fog { Mode off }

			CGPROGRAM
			#pragma exclude_renderers xbox360 ps3 flash
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_TexelSize;

			v2f_img vert(appdata_img v) {
				v2f_img o;
				o.pos = UnityObjectToClipPos(v.vertex);
				#ifdef UNITY_HALF_TEXEL_OFFSET
					v.texcoord.y += _MainTex_TexelSize.y;
				#endif
				#if SHADER_API_D3D9
					if (_MainTex_TexelSize.y < 0)
						v.texcoord.y = 1.0 - v.texcoord.y;
				#endif
				o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, v.texcoord);
				return o;
			}

			fixed4 frag (v2f_img i) : COLOR {
				fixed4 main = tex2D(_MainTex, i.uv);
				main.rgb -= tex2D(_MainTex, i.uv + _MainTex_TexelSize.xy).rgb * 2.0;
				main.rgb += tex2D(_MainTex, i.uv - _MainTex_TexelSize.xy).rgb * 2.0;
				main.rgb = (main.r + main.g + main.b) / 3.0;
				return main;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
