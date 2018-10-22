Shader "Custom/Shader" {
	Properties {
        _MainTex ("Texture", 2D) = ""{}
		_Slices ("Slices", int) = 20
		_Offset ("Offset", float) = 0.05
		_Vertical ("Vertical", int) = 0
		_Loop ("Loop", Int) = 0
	}


	SubShader {
		Pass {
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Slices;
			float _Offset;
			int _Vertical;
			int _Loop;


			// randomNoise: ランダムノイズ
			// 参考: http://qiita.com/shimacpyon/items/d15dee44a0b8b3883f76
			float randomNoise (half2 p){
            	return frac(sin(dot(p, half2(12.9898, 78.233))) * 43758.5453);
        	}


			half4 frag(v2f_img img): COLOR{
				// 動かす向木に合わせた変数をセット
				float slice;
				float offset;
				if(_Vertical == 0){
					slice = img.uv.y;
					offset = img.uv.x;
				} else {
					slice = img.uv.x;
					offset = img.uv.y;
				}

				// 分割位置
				float split = floor(slice * _Slices) / _Slices;
				// ランダム数生成
				float ran = randomNoise(half2(_Slices, split));
				// 時間軸を使用するか
				float time = _Loop == 0 ? 1.0 : _Time.x * 5.0;

				// 指導位置の追加
				offset += sin(time * ran) * _Offset;
				// 少数部をセット
				offset = frac(offset);

				// uv座標セット
				if(_Vertical == 0){
					img.uv.x = offset;
					// img.uv = half2(offset, slice);
				} else {
					img.uv.y = offset;
				}

				return tex2D(_MainTex, img.uv);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
