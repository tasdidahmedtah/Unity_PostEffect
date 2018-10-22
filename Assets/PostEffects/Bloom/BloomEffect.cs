using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BloomEffect : MonoBehaviour {

	public bool on = false;

	[Range(0f, 2f)]
	public float strength = 0.6f;

	[Range(0f, 10f)]
	public float size = 4f;

	[Range(0.00f, 0.80f)]
	public float cutOff = 0.3f;

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


	void Update () {
		if(on)
		{
			material.SetFloat("_Strength", strength);
			material.SetFloat("_Size", size);
			material.SetFloat("_CutOff", cutOff);
		}
	}
}
