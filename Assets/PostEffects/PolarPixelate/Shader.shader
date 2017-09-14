Shader "Custom/Shader" {
	Properties {
        _MainTex("MainTex", 2D) = ""{}
		_Radius("Radius", Float) = 0.05
		_Segments("Segments", Float) = 0.05
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
			float _Radius;
			float _Segments;


			float mod(float a, float b)
			{
				return a - floor(a / b) * b;
			}


			fixed4 frag(v2f_img i): COLOR
			{
				fixed2 normCoord = 2.0 * i.uv - 1.0;
				float r = length(normCoord);
				float phi = atan2(normCoord.y, normCoord.x);

				r = r - mod(r, _Radius);
				phi = phi - mod(phi, _Segments);
				normCoord.x = r * cos(phi);
				normCoord.y = r * sin(phi);

				fixed2 textureCoordinateToUse = normCoord / 2.0 + 0.5;
				fixed4 c = tex2D(_MainTex, textureCoordinateToUse);

				// fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
