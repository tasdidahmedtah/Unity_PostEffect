Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Float) = 0.3
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;


			fixed4 frag(v2f_img i): COLOR
			{
				fixed4 c = tex2D(_MainTex, i.uv);
				// c.rgb += brightness;
				if (_Amount > 0.0) {
					c.rgb = (c.rgb - 0.5) / (1.0 - _Amount) + 0.5;
				} else {
					c.rgb = (c.rgb - 0.5) * (1.0 + _Amount) + 0.5;
				}
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
