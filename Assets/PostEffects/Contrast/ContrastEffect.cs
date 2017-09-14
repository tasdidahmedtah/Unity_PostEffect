using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ContrastEffect : MonoBehaviour {

	public bool on = false;


	[Range(0.00f, 1.00f)]
	public float amount = 0.30f;

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
			material.SetFloat("_Amount", amount);
		}
	}
}
