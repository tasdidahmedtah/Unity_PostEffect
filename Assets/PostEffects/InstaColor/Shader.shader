Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Strength ("Strength", Float) = 0.5
		_Style ("Style", Int) = 0
	}



	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Strength;
			int _Style;


			fixed4 frag(v2f_img i): COLOR
			{
    			fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
