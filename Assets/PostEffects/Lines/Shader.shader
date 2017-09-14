Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Int) = 400
		_Strength ("Strength", Float) = 0.5
		_Angle ("Angle", Float) = 0.5

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


			fixed4 frag(v2f_img i): COLOR
			{
				fixed4 c = tex2D(_MainTex, i.uv);
				c += sin(i.uv.x * _Amount * (1.0-_Angle) + i.uv.y * _Amount * _Angle) * _Strength;
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
