using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstaColorEffect : MonoBehaviour {

	public bool on = false;

	[Range(0f, 1f)]
	public float strength = 0.5f;

	[Range(0, 3)]
	public int style = 0;

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
			material.SetInt("_Style", style);
		}
	}
}
