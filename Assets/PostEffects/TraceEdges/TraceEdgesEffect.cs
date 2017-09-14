using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TraceEdgesEffect : MonoBehaviour {

	public bool on = false;

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
}
