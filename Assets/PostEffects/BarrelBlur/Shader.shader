Shader "Custom/Shader" {
	Properties {
		_MainTex ("MainTex", 2D) = "" {}
		_Amount ("Amount", Float) = 0.05
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;
			float _Amount;
			// uniform sampler2D tDiffuse;
			// uniform float amount;
			// uniform float time;
			// varying vec2 vUv;
			int NUM_ITER = 16;
			float RECI_NUM_ITER_F = 1.0 / 16.0;
			float GAMMA = 2.2;
			float MAX_DIST_PX = 200.0;

			// fixed4 frag(v2f_img i): COLOR
			// {
			// 	fixed4 c = tex2D(_MainTex, i.uv);
			// 	return c;
			// }


			fixed2 barrelDistortion(fixed2 p, fixed2 amt){
				p = 2.0 * p - 1.0;
				//float BarrelPower = 1.125;
				float MAXBARREL_POWER = 3.0;
				float theta  = atan2(p.y, p.x);
				float radius = length(p);
				radius = pow(radius, 1.0 + MAXBARREL_POWER * amt.x);
				p.x = radius * cos(theta);
				p.y = radius * sin(theta);
				return 0.5 * (p + 1.0);
			}

			float sat(float t){
				return clamp(t, 0.0, 1.0);
			}

			float linterp(float t){
				return sat(1.0 - abs(2.0 * t - 1.0));
			}

			float remap(float t, float a, float b){
				return sat((t - a) / (b - a));
			}

			fixed3 spectrum_offset(float t){
				fixed3 ret;
				float lo = step(t, 0.5);
				float hi = 1.0 - lo;
				float w = linterp(remap(t, 1.0/6.0, 5.0/6.0));
				ret = fixed3(lo, 1.0, hi) * fixed3(1.0-w, w, 1.0-w);
				float v = 1.0 / 2.2;
				return pow(ret, fixed3(v, v, v));
			}

			float nrand(fixed2 n){
				return frac(sin(dot(n.xy, fixed2(12.9898, 78.233))) * 43758.5453);
			}

			fixed3 lin2srgb(fixed3 c){
				return pow(c, fixed3(GAMMA, GAMMA, GAMMA));
			}

			fixed3 srgb2lin(fixed3 c){
				float v = 1.0 / GAMMA;
				return pow(c, fixed3(v, v, v));
			}

			fixed4 frag(v2f_img i): COLOR
			{
				fixed2 max_distort = fixed2(_Amount, _Amount);
				fixed2 oversiz = barrelDistortion(fixed2(1, 1), max_distort);
				i.uv = 2.0 * i.uv - 1.0;
				i.uv = i.uv / (oversiz * oversiz);
				i.uv = 0.5 * i.uv + 0.5;

				fixed3 sumcol = fixed3(0, 0, 0);
				fixed3 sumw = fixed3(0, 0, 0);
				float rnd = nrand(i.uv + frac(_Time.y));

				for(int k=0; k < NUM_ITER; ++k)
				{
					float t = (float(k) + rnd) * RECI_NUM_ITER_F;
					fixed3 w = spectrum_offset(t);
					sumw += w;
					sumcol += w * srgb2lin(tex2D(_MainTex, barrelDistortion(i.uv, max_distort * t)).rgb);
				}

				sumcol.rgb /= sumw;

				fixed3 outcol = lin2srgb(sumcol.rgb);
				outcol += rnd/255.0;

				fixed4 c = fixed4( outcol.r, outcol.g, outcol.b, 1.0);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}

