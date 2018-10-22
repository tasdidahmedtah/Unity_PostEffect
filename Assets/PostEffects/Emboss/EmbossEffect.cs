using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EmbossEffect : MonoBehaviour {
	public bool on = false;

	// [Range(0.1f, 1f)]
	// public float scale = 0.8f;

	public Material material;


	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		if(on)
		{
			Graphics.Blit(src, dest, material);
		}
		else
		{
			Graphics.Blit(src, dest);
		}
	}


	void Update()
	{
		if(on)
		{
			// material.SetFloat("_Scale", scale);
		}
	}
}