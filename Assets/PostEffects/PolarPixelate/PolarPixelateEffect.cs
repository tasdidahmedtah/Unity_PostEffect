using UnityEngine;
using System.Collections;

public class PolarPixelateEffect : MonoBehaviour {

	public bool on = false;

	[Range(0f, 0.3f)]
	public float radius = 0.05f;

	[Range(0, 0.1f)]
	public float segments = 0.05f;

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
			material.SetFloat("_Radius", radius);
			material.SetFloat("_Segments", segments);
		}
	}
}