import * as React from "react";
import { Grid, GridColumn } from "@progress/kendo-react-grid";
import { Slider, NumericTextBox } from "@progress/kendo-react-inputs";
import "@progress/kendo-theme-default/dist/all.css";

import {
  getHighRankedPlayers,
} from "../api/fetch.js";

const MyPager = (props) => {
  const currentPage = Math.floor(props.skip / props.take) + 1;
  const totalPages = Math.ceil((props.total || 0) / props.take);

  const handleChange = (e) => {
    if (props.onPageChange) {
      props.onPageChange({
        target: e.target,
        skip: (e.value - 1) * props.take,
        take: props.take,
        syntheticEvent: e,
        nativeEvent: e.nativeEvent,
      });
    }
  };

  return (
    <div
      className={props.className}
      style={{
        borderTop: "1px solid",
        borderTopColor: "inherit",
      }}
    >
      <div className="row">
        <div className="col-4">
          <Slider
            buttons={true}
            step={1}
            value={currentPage}
            min={1}
            max={totalPages}
            onChange={handleChange}
          />
        </div>
        <div className="col-4">
          <NumericTextBox
            value={currentPage}
            onChange={handleChange}
            min={1}
            max={totalPages}
          />
        </div>
        <div className="col-4">{`Page ${currentPage} of ${totalPages}`}</div>
      </div>
    </div>
  );
};

const cellWithBackGround = (props) => {
  const { rankDiff } = props.dataItem
  const icon = (rankDiff < 0)  ? (
    <span className="k-icon k-i-sort-desc-sm" />
  ) : (rankDiff > 0) ? (
    <span className="k-icon k-i-sort-asc-sm" />
    ) : (
        <span className="k-icon k-i-equal" />
  );
  const style = {
    backgroundColor: (rankDiff < 0)
      ? "rgb(243, 23, 0, 0.32)"
      : (rankDiff > 0)
        ? "rgb(55, 180, 0,0.32)"
        : "yellow",
  };
  const field = props.field || "";
  return (
    <td style={style}>
      {props.dataItem[field]} {icon}
    </td>
  );
};

const Players = () => {
  const [players, setPlayers] = React.useState([0]);

  const [page, setPage] = React.useState({
    skip: 0,
    take: 20,
  });

  React.useEffect(() => {
    getHighRankedPlayers().then((data) => {
      setPlayers(data)
    })
  }, [])

  const pageChange = (event) => {
    setPage(event.page);
  };

  return (
    <div>
      <Grid
        style={{
          minHeight: "100vh",
        }}
        data={players.slice(page.skip, page.take + page.skip)}
        skip={page.skip}
        take={page.take}
        total={players.length}
        pageable={true}
        onPageChange={pageChange}
        pager={MyPager}
      >
        <GridColumn field="country" title="Country"/>
        <GridColumn field="name" title="Player Name"/>
        <GridColumn field="rank"  title="Current Rank"/>
        <GridColumn field="money" title="Money"/>
        <GridColumn field="rankDiff" cell={cellWithBackGround} title="Daily Diff"/>
      </Grid>
    </div>
  );
};

export default Players;