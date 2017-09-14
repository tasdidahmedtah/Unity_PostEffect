using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TiltShiftEffect : MonoBehaviour {

	public bool on = false;

	[Range(0.001f, 0.02f)]
	public float amount = 0.01f;

	[Range(0f, 1f)]
	public float position = 0.35f;

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
			material.SetFloat("_Position", position);
		}
	}
}
