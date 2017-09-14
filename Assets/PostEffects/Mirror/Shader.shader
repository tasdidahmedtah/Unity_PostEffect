Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Side ("Side", Int) = 0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag

			sampler2D _MainTex;
			int _Side;

			fixed4 frag(v2f_img i): COLOR
			{
				if(_Side == 0){
					if(0.5 < i.uv.x){ i.uv.x = 1.0 - i.uv.x;}
				} else if(_Side == 1) {
					if(0.5 > i.uv.x){ i.uv.x = 1.0 - i.uv.x;}
				} else if(_Side == 2) {
					if(0.5 > i.uv.y){ i.uv.y = 1.0 - i.uv.y;}
				} else {
					if(0.5 < i.uv.y){ i.uv.y = 1.0 - i.uv.y;}
				}

				fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
