package io.banana.dokkaexample.ui.team_list

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import io.banana.dokkaexample.R
import io.banana.domain.models.Scuderia

class TeamAdapter : RecyclerView.Adapter<TeamAdapter.ViewHolder>() {

    var scuderias: List<Scuderia> = emptyList()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        return ViewHolder(
            inflater.inflate(
                R.layout.item_scuderia,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(scuderias[position])
    }

    override fun getItemCount(): Int = scuderias.size

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val nameView: TextView = itemView.findViewById(R.id.text_scuderia_name)
        fun bind(scuderia: Scuderia) {
            nameView.text = scuderia.name
        }

    }
}