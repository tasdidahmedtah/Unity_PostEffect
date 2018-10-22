using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HueSaturationEffect : MonoBehaviour {

	public bool on = false;

	[Range(-1, 1)]
	public int saturation = 0;

	[Range(0, 360)]
	public int angle = 0;

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


	void Update () {
		if(on)
		{
			material.SetInt("_Saturation", saturation);
			material.SetInt("_Angle", angle);
			material.SetFloat("_Speed", speed);
		}
	}
}
