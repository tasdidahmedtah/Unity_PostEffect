Shader "Custom/Shader" {
	Properties {
		_MainTex ("Texture", 2D) = "" {}
		_Brightness ("Brightness", int) = 0
		_Contrast ("Contrast", int) = 0
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			int _Brightness;
			int _Contrast;


			half4 frag(v2f_img img): COLOR {
				half4 col = tex2D(_MainTex, img.uv);
				half4 dstColor = half4((col.rgb - 0.5) * (_Contrast + 0.25) * 2.5 + 0.5, 1.0);
				return clamp(dstColor, 0.0, 1.0);


				// if (contrast > 0.0) {
				// 	col.rgb = (col.rgb - 0.5) / (1.0 - contrast) + 0.5;
				// } else {
				// 	col.rgb = (col.rgb - 0.5) * (1.0 + contrast) + 0.5;
				// }
				// return col;


// uniform sampler2D tDiffuse;
// uniform float brightness;
// uniform float contrast;
// varying vec2 vUv;
// void main() {
// 	gl_FragColor = texture2D( tDiffuse, vUv );
// 	gl_FragColor.rgb += brightness;
// 	if (contrast > 0.0) {
// 		gl_FragColor.rgb = (gl_FragColor.rgb - 0.5) / (1.0 - contrast) + 0.5;
// 	} else {
// 		gl_FragColor.rgb = (gl_FragColor.rgb - 0.5) * (1.0 + contrast) + 0.5;
// 	}
// }
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}





