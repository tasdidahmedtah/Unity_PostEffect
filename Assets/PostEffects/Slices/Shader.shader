Shader "Custom/Shader" {
	Properties {
        _MainTex("MainTex", 2D) = ""{}
		_Slices("Slices", Int) = 20
		_Offset("Offset", Float) = 0.05
	}


	SubShader {
		Pass {
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"

			// 定義されている頂点シェーダー関数
			#pragma vertex vert_img
			// フラグメントシェーダー関数
			#pragma fragment frag

			sampler2D _MainTex;
			float _Slices;
			float _Offset;
			// float4 _Time;


			float fract(float x)
			{
				return x - floor(x);
			}


			float rand(fixed2 co)
			{
				fixed2 v2 = fixed2(12.9898, 78.233);
				return fract(sin(dot(co.xy , v2)) * 43758.5453);
			}


			fixed4 frag(v2f_img i): COLOR
			{
				fixed2 p = i.uv;
				float yInt = floor(i.uv.y * _Slices) / _Slices;
				float rnd = rand(fixed2(yInt, yInt));

				p.x += sin((_Time.y*10.0) * rnd / 5.0) * _Offset - _Offset / 2.0;
				p.x = fract(p.x);

				fixed4 c = tex2D(_MainTex, p);
				// fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
