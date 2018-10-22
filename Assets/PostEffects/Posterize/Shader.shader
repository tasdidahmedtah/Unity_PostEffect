Shader "Custom/Shader" {
	// 参考: https://github.com/flippyhead/heaid/blob/master/shaders/v001%20Shaders%20Beta%202/Shaders/v001%20Effects/v001.posterize.fp.glsl

	Properties {
		_MainTex ("Texture", 2D) = ""{}
		_Level ("Level", int) = 4
	}


	SubShader {
		Pass {
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Level;


			half4 frag (v2f_img i): COLOR
			{
				half4 c = tex2D(_MainTex, i.uv);
				// 階調化
				c.rgb = floor(c * _Level) / _Level;
				return c;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}