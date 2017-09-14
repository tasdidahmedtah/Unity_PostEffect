Shader "Custom/Shader" {
	Properties {
		_MainTex("MainTex", 2D) = ""{}
		_Levels ("Amount", Float) = 4.0
	}



	SubShader {
		Pass {
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"

			// 定義されている頂点シェーダー関数
			#pragma vertex vert_img
			// フラグメントシェーダー関数
			#pragma fragment frag

			// 使用するパラメータ
			sampler2D _MainTex;
			float _Levels;


			fixed4 frag (v2f_img i): COLOR
			{
				fixed4 c = tex2D(_MainTex, i.uv);
				c.rgb = floor((c.rgb * _Levels) + fixed3(0.5, 0.5, 0.5)) / _Levels;
				return c;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
