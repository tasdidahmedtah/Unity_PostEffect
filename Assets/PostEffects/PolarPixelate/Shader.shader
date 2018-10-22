Shader "Custom/Shader" {
	Properties {
        _MainTex("Texture", 2D) = ""{}
		_Radius("Radius", float) = 0.05
		_Segments("Segments", float) = 0.05
	}


	SubShader {
		Pass {
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Radius;
			float _Segments;


			// mod: HLSLには、GLSLのmod関数がない
			float mod(float a, float b){
				return a - floor(a / b) * b;
			}

			half4 frag(v2f_img img): COLOR{
				// センタリング
				half2 center = 2.0 * img.uv - 1.0;

				// ベクトルの長さを取得
				float distance = length(center);

				// アークタンジェント取得
				float arcTan = atan2(center.y, center.x);

				// モザイク用に円の半径に長さを調整
				distance = distance - mod(distance, _Radius);

				// モザイク用に分割数を調整
				arcTan = arcTan - mod(arcTan, _Segments);

				// uv座標の取得
				center.x = distance * cos(arcTan);
				center.y = distance * sin(arcTan);

				// HLSL座標に調整
				half2 uv = center / 2.0 + 0.5;
				return tex2D(_MainTex, uv);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
