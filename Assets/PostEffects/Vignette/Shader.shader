Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Float) = 1.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;


			fixed4 frag(v2f_img i): COLOR
			{
				// fixed4 texel = tex2D(_MainTex, i.uv);
				// fixed2 uv = (i.uv - fixed2(0.5, 0.5)) * fixed2( offset );


				// vec4 texel = texture2D( tDiffuse, vUv );
				// vec2 uv = ( vUv - vec2( 0.5 ) ) * vec2( offset );
				// gl_FragColor = vec4( mix( texel.rgb, vec3( 1.0 - darkness ), dot( uv, uv ) ), texel.a );


				fixed4 texel = tex2D(_MainTex, i.uv);
				fixed2 uv = (i.uv - fixed2(0.5, 0.5)) * fixed2(_Amount, _Amount);
				float a = 1.0 - 1.0;
				float v = lerp(texel.rgb, fixed3(a, a, a), dot(uv, uv));
				fixed4 c = fixed4(v, v, v, texel.a);
				// fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
