Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Range(0, 0.1)) = 0.005
		_Speed ("Speed", Range(0, 20)) = 10
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;
			float _Speed;


			half4 frag (v2f_img img): COLOR {
				// ずらす方向
				float speed = _Time.y * _Speed / 2.0;
				// ずらす位置
				half2 offset = _Amount * half2(cos(speed), sin(speed));

				// rgb別にずらしたカラーを生成
				half4 cr = tex2D(_MainTex, img.uv + offset);
				half4 cb = tex2D(_MainTex, img.uv - offset);
				half4 cga = tex2D(_MainTex, img.uv);

				return half4(cr.r, cga.g, cb.b, cga.a);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
