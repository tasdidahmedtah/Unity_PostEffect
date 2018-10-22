using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScanlinesEffect : MonoBehaviour {

	public bool on = false;

	[Range(0, 1)]
	public int grayscale = 0;

	[Range(100, 1000)]
	public int amount = 800;

	[Range(0, 2f)]
	public float strength = 0.9f;

	[Range(0, 2f)]
	public float noise = 0.4f;

	[Range(0f, 10f)]
	public float speed = 5f;



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
			material.SetInt("_Grayscale", grayscale);
			material.SetInt("_Amount", amount);
			material.SetFloat("_Strength", strength);
			material.SetFloat("_Noise", noise);
			material.SetFloat("_Speed", speed);
		}
	}
}
