Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Grayscale ("Grayscale", int) = 0
		_Amount ("MainTex", int) = 800
		_Strength ("Strength", float) = 0.9
		_Noise ("Noise", float) = 0.4
		_Speed ("Speed", float) = 5.0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Grayscale;
			int _Amount;
			float _Strength;
			float _Noise;
			float _Speed;


			float mod(float a, float b)	{
				return a - floor(a / b) * b;
			}

			float randomNoise(half2 p) {
            	return frac(sin(dot(p, half2(12.9898, 78.233))) * 43758.5453);
        	}


			half4 frag(v2f_img img): COLOR {
				// レンダリングデータ生成
				half4 uv = tex2D(_MainTex, img.uv);
				float speed = (img.uv.y + _Speed) * _Amount;
				// float speed = (img.uv.y + sin(_Time.x * _Speed)) * _Amount;

				half2 sc = half2(cos(speed), sin(speed));


				float x = img.uv.x * img.uv.y * _Time.y * 1000.0;
				x = mod(x, 13.0) * mod(x, 123.0);

				float dx = mod(x, 0.01);

				half3 col = uv.rgb + uv.rgb * clamp(0.1 + dx * 100.0, 0.0, 1.0);
				col += uv.rgb * half3(sc.x, sc.y, sc.x) * _Strength;

				col = uv.rgb + clamp(_Noise, 0.0, 1.0) * (col - uv.rgb);


				// col = uv.rgb + randomNoise(half2(img.uv.y, _Noise)) * (col - uv.rgb);

				if(_Grayscale){
					col = col.r * 0.3 + col.g * 0.59 + col.b * 0.11;
				}

				return half4(col, uv.a);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
