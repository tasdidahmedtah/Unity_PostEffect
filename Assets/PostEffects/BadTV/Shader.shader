Shader "Custom/Shader" {
	Properties {
		_MainTex("MainTex", 2D) = ""{}
		_ThickDistort ("ThickDistort", Float) = 3.0
		_FineDistort ("FineDistort", Float) = 1.0
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


			sampler2D _MainTex;
			Float _ThickDistort;
			Float _FineDistort;


			fixed3 mod289(fixed3 x) {
				return x - floor(x * (1.0 / 289.0)) * 289.0;
			}

			fixed2 mod289(fixed2 x) {
				return x - floor(x * (1.0 / 289.0)) * 289.0;
			}

			fixed3 permute(fixed3 x) {
				return mod289(((x * 34.0) + 1.0) * x);
			}

			float fract(float x)
			{
				return x - floor(x);
			}

			float snoise(fixed2 v) {
				fixed4 C = fixed4(
					0.211324865405187,  // (3.0-sqrt(3.0))/6.0",
					0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)",
					-0.577350269189626, // -1.0 + 2.0 * C.x",
					0.024390243902439   // 1.0 / 41.0",
				);
				fixed2 i = floor(v + dot(v, C.yy));
				fixed2 x0 = v - i + dot(i, C.xx);
				fixed2 i1;
				i1 = (x0.x > x0.y) ? fixed2(1.0, 0.0) : fixed2(0.0, 1.0);
				fixed4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod289(i); // Avoid truncation effects in permutation",
				fixed3 p = permute(permute(i.y + fixed3(0.0, i1.y, 1.0)) + i.x + fixed3(0.0, i1.x, 1.0));
				fixed3 m = max(0.5 - fixed3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
				m = m * m;
				m = m * m;
				fixed3 x = 2.0 * fract(p * C.www) - 1.0;
				fixed3 h = abs(x) - 0.5;
				fixed3 ox = floor(x + 0.5);
				fixed3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
				fixed3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot(m, g);
			}


			fixed4 frag (v2f_img i): COLOR
			{
				float ty = _Time.x * 10;
				float yt = i.uv.y - ty;
				float offset = snoise(fixed2(yt * 3.0, 0.0)) * 0.2;
				float rollSpeed = 0.05;

				offset = offset * _ThickDistort * offset * _ThickDistort * offset;

				offset += snoise(fixed2(yt * 50.0, 0.0)) * _FineDistort * 0.001;

				fixed4 c = tex2D(_MainTex, fixed2(fract(i.uv.x + offset), fract(i.uv.y - _Time.y * rollSpeed)));
				return c;
			}
			ENDCG
		}



	}
	FallBack "Diffuse"
}
