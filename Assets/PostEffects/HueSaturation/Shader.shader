Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Saturation ("Saturation", int) = 0
		_Angle ("Angle", int) = 0
		_Speed ("Speed", float) = 5.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Saturation;
			int _Angle;
			int _Speed;


			half4 frag(v2f_img img): COLOR {
				half4 col = tex2D(_MainTex, img.uv);
				float angle = (_Angle-180.0)/180 + sin(_Speed * _Time.x * 5.0);
				float s = sin(angle * 3.1416);
				float c = cos(angle * 3.1416);

				half3 weights = (half3(2.0 * c, - sqrt(3.0) * s - c, sqrt(3.0) * s - c) + 1.0) / 3.0;
				float len = length(col.rgb);

				col.rgb = half3(dot(col.rgb, weights.xyz), dot(col.rgb, weights.zxy), dot(col.rgb, weights.yzx));

				float average = (col.r + col.g + col.b) / 3.0;

				if (_Saturation > 0.0) {
					col.rgb += (average - col.rgb) * (1.0 - 1.0 / (1.001 - _Saturation));
				} else {
					col.rgb += (average - col.rgb) * (-_Saturation);
				}
				return col;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
