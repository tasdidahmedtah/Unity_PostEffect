Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Range(0,0.1)) = 0.005
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;


			fixed4 frag (v2f_img i): COLOR
			{
				fixed2 offset = _Amount * fixed2(cos(_Time.y), sin(_Time.y));
				fixed4 cr = tex2D(_MainTex, i.uv + offset);
				fixed4 cb = tex2D(_MainTex, i.uv - offset);
				fixed4 cga = tex2D(_MainTex, i.uv);
				fixed4 c = fixed4(cr.r, cga.g, cb.b, cga.a);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
