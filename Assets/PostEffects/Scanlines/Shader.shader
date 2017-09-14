Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Grayscale ("Grayscale", Int) = 0
		_Amount ("MainTex", Int) = 800
		_Strength ("Strength", Float) = 0.9
		_Noise ("Noise", Float) = 0.4
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


			float mod(float a, float b)
			{
				return a - floor(a / b) * b;
			}


			fixed4 frag(v2f_img i): COLOR
			{
				fixed4 cTextureScreen = tex2D(_MainTex, i.uv);
				fixed2 sc = fixed2(sin(i.uv.y * _Amount), cos(i.uv.y * _Amount));

				float x = i.uv.x * i.uv.y * _Time.y * 1000.0;
				x = mod(x, 13.0) * mod(x, 123.0);

				float dx = mod(x, 0.01);

				fixed3 v = cTextureScreen.rgb + cTextureScreen.rgb * clamp(0.1 + dx * 100.0, 0.0, 1.0);
				v += cTextureScreen.rgb * fixed3(sc.x, sc.y, sc.x) * _Strength;
				v = cTextureScreen.rgb + clamp(_Noise, 0.0, 1.0) * (v - cTextureScreen.rgb);

				if(_Grayscale)
				{
					v = v.r * 0.3 + v.g * 0.59 + v.b * 0.11;
				}

				fixed4 c = fixed4(v, cTextureScreen.a);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
