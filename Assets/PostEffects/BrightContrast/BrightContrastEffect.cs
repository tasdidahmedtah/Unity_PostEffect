using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BrightContrastEffect : MonoBehaviour {

	public bool on = false;

	[Range(-150, 150)]
	public int brightness = 0;

	[Range(-50, 100)]
	public int contrast = 0;


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
			material.SetInt("_Brightness", brightness);
			material.SetInt("_Contrast", contrast);
		}
	}
}
