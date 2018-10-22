using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LinesEffect : MonoBehaviour {
	public bool on = false;

	[Range(400, 2000)]
	public int amount = 400;

	[Range(0f, 1f)]
	public float strength = 0.5f;

	[Range(0f, 1f)]
	public float angle = 0.5f;

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
			material.SetInt("_Amount", amount);
			material.SetFloat("_Strength", strength);
			material.SetFloat("_Angle", angle);
		}

	}
}
