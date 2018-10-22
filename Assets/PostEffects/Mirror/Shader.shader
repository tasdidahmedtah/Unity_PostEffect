Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Side ("Side", int) = 0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Side;


			half4 frag(v2f_img img): COLOR {
				// 折り返し基準を超えたら反転したuv座標をセット
				if(_Side == 0){
					// 左半分
					if(0.5 < img.uv.x){ img.uv.x = 1.0 - img.uv.x;}
				} else if(_Side == 1) {
					// 右半分
					if(0.5 > img.uv.x){ img.uv.x = 1.0 - img.uv.x;}

				} else if(_Side == 2) {
					// 上半分
					if(0.5 > img.uv.y){ img.uv.y = 1.0 - img.uv.y;}

				} else {
					// 下半分
					if(0.5 < img.uv.y){ img.uv.y = 1.0 - img.uv.y;}
				}

				return tex2D(_MainTex, img.uv);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
