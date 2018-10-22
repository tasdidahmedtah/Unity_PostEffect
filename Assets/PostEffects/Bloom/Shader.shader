Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Strength ("Strength", float) = 0.5
		_Size ("Size", float) = 4.0
		_CutOff ("CutOff", float) = 0.5
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Strength;
			float _Size;
			float _CutOff;


			half4 frag(v2f_img i): COLOR{
				float h = _Size / _ScreenParams.x;
				float v = _Size / _ScreenParams.y;

				half4 sum = half4(0, 0, 0, 0);
				sum += (tex2D(_MainTex, half2(i.uv.x - 4.0 * h, i.uv.y))- _CutOff) * 0.051;
				sum += (tex2D(_MainTex, half2(i.uv.x - 3.0 * h, i.uv.y))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, half2(i.uv.x - 2.0 * h, i.uv.y))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, half2(i.uv.x - 1.0 * h, i.uv.y))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y))- _CutOff) * 0.1633;
				sum += (tex2D(_MainTex, half2(i.uv.x + 1.0 * h, i.uv.y))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, half2(i.uv.x + 2.0 * h, i.uv.y))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, half2(i.uv.x + 3.0 * h, i.uv.y))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, half2(i.uv.x + 4.0 * h, i.uv.y))- _CutOff) * 0.051;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y - 4.0 * v))- _CutOff) * 0.051;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y - 3.0 * v))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y - 2.0 * v))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y - 1.0 * v))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y))- _CutOff) * 0.1633;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y + 1.0 * v))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y + 2.0 * v))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y + 3.0 * v))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, half2(i.uv.x, i.uv.y + 4.0 * v))- _CutOff) * 0.051;

				half4 base = tex2D(_MainTex, i.uv);
				return base + max(sum, 0.0) * _Strength;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}