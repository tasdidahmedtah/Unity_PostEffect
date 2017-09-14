using UnityEngine;
using System.Collections;

public class MosaicEffect : MonoBehaviour {

	public bool on = false;

	[Range(0, 200)]
	public int horizontal = 20;

	[Range(0, 200)]
	public int vertical = 20;

	public Material material;


	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		if(on)
		{
			Graphics.Blit (src, dest, material);
		}
		else
		{
			Graphics.Blit (src, dest);
		}
	}


	void Update()
	{
		if(on)
		{
			// マテリアルに値を渡す
			material.SetInt("_Horizontal", horizontal);
			material.SetInt("_Vertical", vertical);
		}
	}
}