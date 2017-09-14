Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Saturation ("Saturation", Int) = 0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Saturation;


			fixed4 frag(v2f_img i): COLOR
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				// float angle = hue * 3.14159265;
				float angle = _Time.y * 3.14159265;
				float s = sin(angle);
				float c = cos(angle);
				fixed3 weights = (fixed3(2.0 * c, - sqrt(3.0) * s - c, sqrt(3.0) * s - c) + 1.0) / 3.0;
				float len = length(col.rgb);

				col.rgb = fixed3(dot(col.rgb, weights.xyz), dot(col.rgb, weights.zxy),dot(col.rgb, weights.yzx));
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
