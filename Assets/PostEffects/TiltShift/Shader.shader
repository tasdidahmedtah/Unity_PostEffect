Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Float) = 0.01
		_Position ("Position", Float) = 0.35
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;
			float _Position;


			half4 frag(v2f_img i): COLOR
			{
				half4 sum = half4(0, 0, 0, 0);
				float vv = _Amount * abs(_Position - i.uv.y);
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y - 4.0 * vv)) * 0.051;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y - 3.0 * vv)) * 0.0918;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y - 2.0 * vv)) * 0.12245;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y - 1.0 * vv)) * 0.1531;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y)) * 0.1633;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y + 1.0 * vv)) * 0.1531;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y + 2.0 * vv)) * 0.12245;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y + 3.0 * vv)) * 0.0918;
				sum += tex2D(_MainTex, half2(i.uv.x, i.uv.y + 4.0 * vv)) * 0.051;
				return sum;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
