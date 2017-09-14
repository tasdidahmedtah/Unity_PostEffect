using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlicesEffect : MonoBehaviour {

	public bool on = false;

	[Range(1, 200)]
	public int slices = 20;

	[Range(0, 0.1f)]
	public float offset = 0.05f;

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
		}
	}
}
