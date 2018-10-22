using UnityEngine;
using System.Collections;

public class PosterizeEffect : MonoBehaviour {

	public bool on = false;

	[Range(2, 255)]
	public int level = 4;

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
			material.SetFloat("_Level", level);
		}
	}
}