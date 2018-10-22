Shader "Custom/Shader" {
	// 参考: http://developer.download.nvidia.com/shaderlibrary/webpages/shader_library.html#post_bleach_bypass

	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Strength ("Strength", float) = 1.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Strength;


			half4 frag(v2f_img img): COLOR {
				half4 base = tex2D(_MainTex, img.uv);
				half3 lumCoeff = half3(0.25, 0.65, 0.1);
				float lum = dot(lumCoeff, base.rgb);
				half3 blend = half3(lum, lum, lum);
				float L = min(1.0, max(0.0, 10.0 * (lum - 0.45)));
				half3 result1 = 2.0 * base.rgb * blend;
				half3 result2 = 1.0 - 2.0 * (1.0 - blend) * (1.0 - base.rgb);
				half3 newColor = lerp(result1, result2, L);
				float A2 = _Strength * base.a;
				half3 mixRGB = A2 * newColor.rgb;
				mixRGB += ((1.0 - A2) * base.rgb);
				return half4(mixRGB.r, mixRGB.g, mixRGB.b, base.a);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
