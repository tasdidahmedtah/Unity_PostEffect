Shader "Custom/Shader" {
	// 参考: http://rastergrid.com/blog/2011/01/frei-chen-edge-detector/

	Properties {
		_MainTex ("Texture", 2D) = "" {}
	}


	SubShader {
		Pass{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert_img
			#pragma fragment frag


			sampler2D _MainTex;


			half4 frag(v2f_img img): COLOR{
				float3x3 G[2];
				float3x3 g0 = float3x3(
					1.0, 2.0, 1.0,
					0.0, 0.0, 0.0,
					-1.0, -2.0, -1.0
				);
				float3x3 g1 = float3x3(
					1.0, 0.0, -1.0,
					2.0, 0.0, -2.0,
					1.0, 0.0, -1.0
				);

				float3x3 I;
				float2 cnv[2];
				half3 sample;

				G[0] = g0;
				G[1] = g1;

				for (int i=0; i<3; i++){
					for (int j=0; j<3; j++){
						sample = tex2D(_MainTex, img.uv + half2((i-1.0)/_ScreenParams.x,  (j-1.0)/_ScreenParams.y)).rgb;
						I[int(i)][int(j)] = length(sample);
					}
				}

				for (int k=0; k<2; k++){
					float dp3 = dot(G[k][0], I[0]) + dot(G[k][1], I[1]) + dot(G[k][2], I[2]);
					cnv[k] = dp3;
				}

				half v = 0.5 * sqrt(cnv[0] * cnv[0] + cnv[1] * cnv[1]);
				return half4(v, v, v, v);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
