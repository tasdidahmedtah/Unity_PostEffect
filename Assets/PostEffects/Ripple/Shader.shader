Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Strength ("Strength", float) = 0.01
		_Amount ("Amount", int) = 10
		_Speed ("Speed", float) = 10.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Strength;
			int _Amount;
			int _Speed;


			half4 frag(v2f_img img): COLOR{
				// センタリング
				half2 center = 2.0 * img.uv - 1.0;

				// uv座標位置を生成
				float val = _Time.y * _Speed + length(center * _Amount);
				float x = cos(val);
				float y = sin(val);

				// 波の大きさを加える
				img.uv += _Strength * half2(x, y);

				return tex2D(_MainTex, img.uv);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
