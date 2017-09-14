Shader "Custom/Shader" {
	Properties {
		_MainTex("MainTex", 2D) = ""{}
		_Scale("Scale", Float) = 0.8
	}


	SubShader {
		Pass{
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Scale;


			fixed4 frag (v2f_img i): COLOR
			{
				fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
