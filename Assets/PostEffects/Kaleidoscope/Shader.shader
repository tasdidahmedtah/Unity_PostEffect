Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		// _Side ("Side", int) = 0
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
				half2 p = img.uv * 2.0 - 1.0;
				half2 uv;

				float a = atan2(p.y, p.x);

				float r = sqrt(dot(p, p));
				// float time = _Time.y;
				float time = 0;
				float v = 2.0;

				uv.x = v * a / 3.1416;


				uv.y = -time + sin(v * r + time) + .7 * cos(time + v * a);
				float w = .5+.5*(sin(time+v*r)+ .7*cos(time+v*a));
				half3 col = tex2D(_MainTex, uv*.5).xyz;
				col = col*w;

				return half4(col.x, col.y,col.z, 1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}

