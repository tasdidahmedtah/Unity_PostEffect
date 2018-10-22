using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlicesEffect : MonoBehaviour {

	public bool on = false;

	[Range(1, 200)]
	public int slices = 20;

	[Range(0f, 1f)]
	public float offset = 0.1f;

	[Range(0, 1)]
	public int vertical = 0;

	[Range(0, 1)]
	public int loop = 0;

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
			material.SetInt("_Slices", slices);
			material.SetFloat("_Offset", offset);
			material.SetInt("_Vertical", vertical);
			material.SetInt("_Loop", loop);
		}
	}
}
