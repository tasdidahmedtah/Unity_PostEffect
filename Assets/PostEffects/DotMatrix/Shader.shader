Shader "Custom/Shader" {
	Properties {
		_MainTex("MainTex", 2D) = ""{}
		_Amount ("Amount", Int) = 40
		_Size ("Size", Float) = 0.3
		_Blur ("Blur", Float) = 0.3
	}



	SubShader {
		Pass {
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"

			// 定義されている頂点シェーダー関数
			#pragma vertex vert_img
			// フラグメントシェーダー関数
			#pragma fragment frag

			// 使用するパラメータ
			sampler2D _MainTex;
			int _Amount;
			float _Size;
			float _Blur;


			float mod(float a, float b)
			{
				return a - floor(a / b) * b;
			}

			fixed4 mix(fixed4 x, fixed4 y, fixed4 a){
				return x *(1.0 - a) + y * a;
			}

			fixed4 frag (v2f_img i): COLOR
			{
				float dotSize = 1.0 / _Amount;
				fixed2 samplePos = i.uv - mod(i.uv, dotSize) + 0.5 * dotSize;
				float distanceFromSamplePoint = distance(samplePos, i.uv);
				fixed4 col = tex2D(_MainTex, samplePos);
				float step = smoothstep(dotSize * _Size, dotSize *(_Size + _Blur), distanceFromSamplePoint);
				// fixed4 c = mix(col, fixed4(0,0,0,0), step);

				// fixed4 c = step;
				fixed4 c = col;
				// fixed4 c = tex2D(_MainTex, i.uv);
				return c;

				// gl_FragColor = mix(col, vec4(0.0), smoothstep(dotSize * size, dotSize *(size + blur), distanceFromSamplePoint));


				// float dotSize = 1.0/dots;
				// vec2 samplePos = vUv - mod(vUv, dotSize) + 0.5 * dotSize;
				// float distanceFromSamplePoint = distance(samplePos, vUv);
				// vec4 col = texture2D(tDiffuse, samplePos);
				// gl_FragColor = mix(col, vec4(0.0), smoothstep(dotSize * size, dotSize *(size + blur), distanceFromSamplePoint));
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
