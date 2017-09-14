Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Strength ("Strength", Float) = 0.5
		_Size ("Size", Float) = 4.0
		_CutOff ("CutOff", Float) = 0.5
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


			fixed4 frag(v2f_img i): COLOR
			{
				fixed2 resolution = fixed2(1280, 800);
				float h = _Size / resolution.x;
				float v = _Size / resolution.y;

				fixed4 sum = fixed4(0.0, 0.0, 0.0, 0.0);
				sum += (tex2D(_MainTex, fixed2(i.uv.x - 4.0 * h, i.uv.y))- _CutOff) * 0.051 ;
				sum += (tex2D(_MainTex, fixed2(i.uv.x - 3.0 * h, i.uv.y))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, fixed2(i.uv.x - 2.0 * h, i.uv.y))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, fixed2(i.uv.x - 1.0 * h, i.uv.y))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y))- _CutOff) * 0.1633;
				sum += (tex2D(_MainTex, fixed2(i.uv.x + 1.0 * h, i.uv.y))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, fixed2(i.uv.x + 2.0 * h, i.uv.y))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, fixed2(i.uv.x + 3.0 * h, i.uv.y))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, fixed2(i.uv.x + 4.0 * h, i.uv.y))- _CutOff) * 0.051;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y - 4.0 * v))- _CutOff) * 0.051;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y - 3.0 * v))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y - 2.0 * v))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y - 1.0 * v))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y))- _CutOff) * 0.1633;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y + 1.0 * v))- _CutOff) * 0.1531;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y + 2.0 * v))- _CutOff) * 0.12245;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y + 3.0 * v))- _CutOff) * 0.0918;
				sum += (tex2D(_MainTex, fixed2(i.uv.x, i.uv.y + 4.0 * v))- _CutOff) * 0.051;

				fixed4 base = tex2D(_MainTex, i.uv);
				fixed4 c = base + max(sum, 0.0) * _Strength;
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}