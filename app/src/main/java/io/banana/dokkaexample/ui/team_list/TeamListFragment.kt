package io.banana.dokkaexample.ui.team_list

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.RecyclerView
import io.banana.data.datasources.TeamStaticDataSource
import io.banana.data.respositories.TeamRepository
import io.banana.dokkaexample.R
import io.banana.domain.use_cases.GetTeamsUseCase

class TeamListFragment : Fragment() {

    private lateinit var adapter: TeamAdapter

    lateinit var mainViewModel: TeamListViewModel
    private lateinit var loadingView: View
    private lateinit var errorView: View
    private lateinit var emptyView: View

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val dataSource = TeamStaticDataSource()
        val teamsRepository = TeamRepository(dataSource)
        val getTeamsUseCase = GetTeamsUseCase(teamsRepository)
        mainViewModel = TeamListViewModel(getTeamsUseCase)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_team_list, container, false)
        configureRecycler(view.findViewById(R.id.recycler_teams))
        loadingView = view.findViewById(R.id.loadingView)
        errorView = view.findViewById(R.id.errorView)
        emptyView = view.findViewById(R.id.emptyView)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        registerEvents(mainViewModel)
    }

    override fun onStart() {
        super.onStart()

        mainViewModel.start()
    }

    private fun configureRecycler(recyclerView: RecyclerView) {
        adapter = TeamAdapter()
        recyclerView.adapter = adapter
        recyclerView.setHasFixedSize(true)
    }

    private fun registerEvents(viewModel: TeamListViewModel) {
        viewModel.onListLoaded.observe(viewLifecycleOwner) {
            adapter.scuderias = it
        }

        viewModel.onEmptyList.observe(viewLifecycleOwner) {
            emptyView.visibility = if (it.isNotBlank()) View.VISIBLE else View.INVISIBLE
            emptyView.findViewById<TextView>(R.id.emptyText).text = it
        }

        viewModel.onError.observe(viewLifecycleOwner) {
            errorView.visibility = if (it.isNotBlank()) View.VISIBLE else View.INVISIBLE
            errorView.findViewById<TextView>(R.id.errorText).text = it
        }

        viewModel.onLoading.observe(viewLifecycleOwner) {
            loadingView.visibility = if (it) View.VISIBLE else View.INVISIBLE
        }
    }

}