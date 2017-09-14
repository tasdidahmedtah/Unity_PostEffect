Shader "Custom/Mosaic" {

	// #Properties
	// Unity側からシェーダに渡したい値を宣言
	// https://docs.unity3d.com/ja/540/Manual/SL-Properties.html
	Properties {
        _MainTex("Texture", 2D) = ""{}
		_Horizontal("Horizontal", Int) = 20
		_Vertical("Vertical", Int) = 20
	}



	// #SubShader
	// シェーダ本体を記述
	SubShader {
		Pass {
			// シェーダー編集記述開始位置
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"

			// UnityCG.cgincインクルードファイル内で定義された関数
			#pragma vertex vert_img

			// UnityCG.cgincインクルードファイル内で定義されたフラグメントシェーダー関数
			#pragma fragment frag


			// 変数定義
			sampler2D _MainTex;
			int _Horizontal;
			int _Vertical;


			// フラグメントシェダー関数
			// http://www.shibuya24.info/entry/2016/12/16/090000
			half4 frag(v2f_img i): COLOR {
				i.uv.x = floor(i.uv.x * _Horizontal) / _Horizontal;
				i.uv.y = floor(i.uv.y * _Vertical) / _Vertical;
				half4 c = tex2D(_MainTex, i.uv);
				return c;
			}

			// シェーダー編集記述終了位置
			ENDCG
		}
	}


	FallBack "Diffuse"
}
