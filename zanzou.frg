Shader "Custom/Shader" {
	Properties {
        _MainTex ("Texture", 2D) = ""{}
		_Slices ("Slices", Int) = 20
		_Offset ("Offset", Float) = 0.05
		_Random ("Random", Float) = 0.5
		_Vertical ("Vertical", Int) = 0
		_Sway ("Sway", Int) = 0
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
			float _Random;
			int _Vertical;
			int _Sway;


			// randomNoise: ランダムノイズ
			// 参考: http://qiita.com/shimacpyon/items/d15dee44a0b8b3883f76
			float randomNoise (fixed2 p){
            	return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
        	}


			half4 frag(v2f_img i): COLOR{
				// 動かす向木に合わせた変数をセット
				float slice;
				float offset;
				if(_Vertical == 0){
					slice = i.uv.y;
					offset = i.uv.x;
				} else {
					slice = i.uv.x;
					offset = i.uv.y;
				}

				// 分割位置
				float split = floor(slice * _Slices) / _Slices;
				// ランダム数生成 +0.5 は
				float ran = randomNoise(half2(offset, split));
				float time = _Sway == 0 ? 1.0 : _Time.w;

				offset += sin(time * ran / 3.14159) * _Offset;
				// offset += sin(time * ran / (_Random * 3.14159)) * _Offset;
				offset = frac(offset);

				// uv座標セット
				if(_Vertical == 0){
					i.uv.x = offset;
					// i.uv = half2(offset, slice);
				} else {
					i.uv.y = offset;
				}

				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
