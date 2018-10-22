Shader "Custom/Mosaic" {
	// #Properties
	// Unity側からシェーダに渡したい値を宣言
	// https://docs.unity3d.com/ja/540/Manual/SL-Properties.html
	Properties {
        _MainTex ("Texture", 2D) = ""{}
		_Horizontal ("Horizontal", int) = 20
		_Vertical ("Vertical", int) = 20
	}


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
			// https://docs.unity3d.com/ja/540/Manual/SL-UnityShaderVariables.html
			sampler2D _MainTex;
			int _Horizontal;
			int _Vertical;


			// フラグメントシェダー関数
			// http://www.shibuya24.info/entry/2016/12/16/090000
			half4 frag(v2f_img img): COLOR {

				// モザイクのセンター色、取得調整用
				float centerH;
				if(_Horizontal == 1){
					centerH = 0.5;
				} else {
					centerH = 1.0 / float(_Horizontal) * 0.5;
				}

				float centerV;
				if(_Vertical == 1){
					centerV = 0.5;
				} else {
					centerV = 1.0 / float(_Vertical) * 0.5;
				}

				img.uv.x = floor(img.uv.x * _Horizontal) / _Horizontal + centerH;
				img.uv.y = floor(img.uv.y * _Vertical) / _Vertical + centerV;

				return tex2D(_MainTex, img.uv);
			}

			// シェーダー編集記述終了位置
			ENDCG
		}
	}

	// https://docs.unity3d.com/jp/530/Manual/SL-Fallback.html
	FallBack "Diffuse"
}
