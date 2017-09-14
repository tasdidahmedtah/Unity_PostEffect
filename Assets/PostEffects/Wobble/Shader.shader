Shader "Custom/Shader" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Strength ("Strength", float) = 0.01
		_Size ("Size", int) = 10
	}


	SubShader {
		Pass{
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"

			// 定義されている頂点シェーダー関数
			#pragma vertex vert_img
			// フラグメントシェーダー関数
			#pragma fragment frag

			sampler2D _MainTex;
			float _Strength;
			int _Size;

			fixed4 frag(v2f_img i): COLOR
			{
				float speed = 10.0;
				fixed2 p = -1.0 + 2.0 * i.uv;
				float y = cos(_Time.y * speed + length(p * _Size));
				float x = sin(_Time.y * speed + length(p * _Size));
				fixed2 uv = i.uv + _Strength * fixed2(y, x);
				fixed4 c = tex2D(_MainTex, uv);
				return c;
			}
			ENDCG
		}

	}
	FallBack "Diffuse"
}
