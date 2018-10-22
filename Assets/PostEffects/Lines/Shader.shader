Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Amount ("Amount", int) = 400
		_Strength ("Strength", float) = 0.5
		_Angle ("Angle", float) = 0.5

	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Amount;
			float _Strength;
			float _Angle;


			half4 frag(v2f_img img): COLOR {
				half4 c = tex2D(_MainTex, img.uv);
				float borderData = sin(img.uv.x * _Amount * (1.0-_Angle) + img.uv.y * _Amount * _Angle);

				// ボタータのかかり具合を調整
				borderData *= _Strength;

				c += borderData;

				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
