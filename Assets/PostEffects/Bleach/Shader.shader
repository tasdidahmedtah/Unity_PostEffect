Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Strength ("Strength", Float) = 1.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Strength;


			fixed4 frag(v2f_img i): COLOR
			{


				fixed4 base = tex2D(_MainTex, i.uv);
				fixed3 lumCoeff = fixed3(0.25, 0.65, 0.1);
				float lum = dot(lumCoeff, base.rgb);
				fixed3 blend = fixed3(lum, lum, lum);
				float L = min(1.0, max(0.0, 10.0 * (lum - 0.45)));
				fixed3 result1 = 2.0 * base.rgb * blend;
				fixed3 result2 = 1.0 - 2.0 * (1.0 - blend) * (1.0 - base.rgb);
				fixed3 newColor = lerp(result1, result2, L);
				float A2 = _Strength * base.a;
				fixed3 mixRGB = A2 * newColor.rgb;

				mixRGB += ((1.0 - A2) * base.rgb);

				fixed4 c = fixed4(mixRGB.r, mixRGB.g, mixRGB.b, base.a);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
