Shader "Custom/Shader" {
	// thanks: http://rastergrid.com/blog/2011/01/frei-chen-edge-detector/

	// グローバルなプロパティはここでセット
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}


	SubShader {

		Pass{
			CGPROGRAM

			// 定義済みヘルパー関数インクルード
			#include "UnityCG.cginc"
			// 定義されている頂点シェーダー関数
			#pragma vertex vert_img
			// フラグメントシェーダー関数
			#pragma fragment frag

			sampler2D _MainTex;

			fixed4 frag(v2f_img img): COLOR
			{
				float2 size = float2(1280.0, 800.0);
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
				fixed3 sample;

				G[0] = g0;
				G[1] = g1;

				for (float i=0; i<3; i++)
				{
					for (float j=0; j<3; j++)
					{
						sample = tex2D(_MainTex, img.uv + fixed2((i-1.0)/size.x,  (j-1.0)/size.y)).rgb;
						I[int(i)][int(j)] = length(sample);
					}
				}

				for (int i=0; i<2; i++)
				{
					float dp3 = dot(G[i][0], I[0]) + dot(G[i][1], I[1]) + dot(G[i][2], I[2]);
					cnv[i] = dp3;
				}

				fixed v = 0.5 * sqrt(cnv[0]*cnv[0] + cnv[1]*cnv[1]);
				fixed4 c = fixed4(v, v, v, v);
				return c;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
