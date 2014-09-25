<?php // Right side column. Contains the navbar and content of the page  ?>
<aside class="right-side">
<?php // Content Header (Page header)  ?>
<section class="content-header">
	<h1>
		<?php  echo t('Dashboard');?>
	</h1>
<?php
/*
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>
		<?php echo t('Home') ?></a></li>
		<li class="active"><?php echo t('Dashboard')?></li>
	</ol>
*/
?>
</section>
<?php // Main content  ?>
<section class="content dashboard-content">
	<?php // Small boxes (Stat box)  ?>
	<div class="row">
		<?php if($viewAB1Graph){?>
		<div class="col-lg-6 col-xs-6 pie-chart1">
		<?php // small box  ?>
			<div class="small-box">
				<div class="inner">
					<p>
						<?php
							/*
                            echo t($_SESSION['MENU_NAMES_ARRAY']
							[DASHBOARD_AB1_GRAPH]);
                            */
						?>
					</p>
					<img alt="<?php echo t('AB1 Graph');?>"
                                    src="<?php echo IMAGE_URL?>/demo/ab1.PNG"
                                    style="width:100%;height:200px;" />
			</div>

			<?php
				 /*
 					<a href="#" class="small-box-footer">
						<?php echo t('More info'); ?> <i class="fa fa-arrow-circle-right"></i>
					</a>
				*/
			?>
			</div>
		</div>
<?php }?>
<?php // ./col  ?>
<?php if($viewAB2Graph){?>
<div class="col-lg-6 col-xs-6 pie-chart2">
	<?php // small box  ?>
	<div class="small-box">
		<div class="inner">
			<p></p>
			<img alt="<?php echo t('AB2 Graph');?>"
                                    src="<?php echo IMAGE_URL?>/demo/ab2.PNG"
                                    style="width:100%;height:200px;" />
		</div>
		<?php
		 /*
              <div class="icon">
                                    <i class="ion ion-stats-bars"></i>
                                </div>
                                <a href="#" class="small-box-footer">
                                    <?php echo t('More info'); ?> <i class="fa fa-arrow-circle-right"></i>
             </a>
		 */

		 ?>

	</div>
</div>
<?php }?>
<?php // ./col  ?>
	<?php if($viewLogHistory){?>
		<div class="col-lg-6 col-xs-6">
			<?php // small box  ?>
				<div class="log-history">
                    <div class="logTitle">
    					<p>
    						<?php
    							echo t($_SESSION['MENU_NAMES_ARRAY']
                                        [DASHBOARD_LOG_HISTORY]);
                             ?>
                        </p>
                    </div>
                    <div class="log-history-box">
                    	<div class="table-responsive">
                    		<!-- .table - Uses sparkline charts-->
                    		<table class="table table-striped">
                    			<tbody>
                    				<tr>
										<th><?php echo t('Username');?></th>
										<th><?php echo t('IP Address');?></th>
										<th><?php echo t('Last Login Time');?></th>
									</tr>
									<?php
										if(!empty($viewLogs)){
											foreach($viewLogs as $logs){
									?>
									<tr>
										<td>
										<?php echo $logs['user_name'];?>
										</td>
										<td>
										<?php echo $logs['IP'];?>
										</td>
										<td>
										<?php echo $logs['created_at'];?>
										</td>
									</tr>
									<?php } ?>
									<?php
									if($viewAllLogsHistory){
									?>
									<tr>
									<td colspan="3" align="right">
									<a href="<?php echo URL ?>view-logs/view-logs"
									class="small-box-footer">
									<?php echo t('View All'); ?>
									<i class="fa fa-arrow-circle-right"></i>
									</td>
									</a>
									</tr>
									<?php }?>
									<?php }else { ?>
									<?php }?>
									</tbody>
							</table><!-- /.table -->
						</div>
				</div>
			</div>
		</div>
                        <?php }?>
                        <?php // ./col  ?>

                        <?php if($viewQuickLinks){?>
                        <div class="col-lg-6 col-xs-6">
                            <?php // small box  ?>
                            <div class="">
                                <div class="quick-links">
                                    <div class="logTitle">
                                        <p>
                                        <?php

                                        echo t($_SESSION['MENU_NAMES_ARRAY']
                                        [DASHBOARD_QUICK_LINKS]);
                                        ?>
                                        </p>
                                    </div>
                                    <div id="quickLinks">
                                    <?php
                                     $searchArray = array('class="dropdown"',
                                     'class="dropdown-toggle"',
                                     'data-toggle="dropdown"',
                                     'class="dropdown-menu"',
                                     '<b class="caret"></b>');
                                     $replaceArray = array('');
                                     $quickLinks
                                     = str_replace($searchArray, $replaceArray,
                                     $_SESSION['MENU_HTML']);
                                     echo $quickLinks;
                                    ?>
                                    </div>

                                </div>
                                <?php
                                /*
                                <div class="icon">
                                    <i class="ion ion-person-add"></i>
                                </div>
                                <a href="#" class="small-box-footer">
                                    <?php echo t('More info'); ?> <i class="fa fa-arrow-circle-right"></i>
                                </a>
                                */
                                ?>
                            </div>
                        </div>
                        <?php }?>
                        <?php // ./col  ?>

                    </div><?php // /.row  ?>

                    <?php // top row  ?>
                    <div class="row">
                        <div class="col-xs-12 connectedSortable">

                        </div><?php // /.col  ?>
                    </div>
                    <?php // /.row  ?>

                    <?php // Main row  ?>
                    <div class="row">
                        <?php // Left col  ?>
                        <section class="col-lg-6 connectedSortable">
                            <?php // Custom tabs (Charts with tabs) ?>
                            <?php if($viewSalesGraph){?>
                            <div class="nav-tabs-custom">
                                <?php // Tabs within a box  ?>
                                <ul class="nav nav-tabs pull-right">
                                    <li class="pull-left header"><i class="fa fa-inbox"></i>
                                    <?php echo t('Sales');?></li>
                                </ul>
                                <div class="tab-content no-padding">
                                    <?php // Morris chart - Sales  ?>
                                    <div class="chart tab-pane active" id="revenue-chart"
                                    style="position: relative; height: 300px;"></div>
                                </div>
                            </div>
                            <?php }?>
                            <?php if($noDashboardItems &&
                            $_SESSION['MENU_HTML'] == ''){
                                ?>
                                <div class="accessdenied">
                                <?php echo DASHBOARD_MENU_NO_ITEMS;?>
                                </div>
                                <?php
                            }elseif($noDashboardItems){
                                ?>
                                <div class="accessdenied">
                                <?php echo DASHBOARD_NO_ITEMS;?>
                                </div>
                                <?php

                            }elseif($_SESSION['MENU_HTML'] == ''){
                                ?>
                                <div class="accessdenied">
                                <?php echo DASHBOARD_NO_MENUS;?>
                                </div>
                                <?php

                            }?>


                        </section><?php // /.Left col  ?>
                        <?php // right col (We are only adding the ID to make the widgets sortable) ?>
                        <section class="col-lg-6 connectedSortable">

                        </section><?php // right col  ?>
                    </div><?php // /.row (main row)  ?>

                </section><?php // /.content  ?>
            </aside><?php // /.right-side  ?>

<script type="text/javascript">
$(document).ready(function() {
  var maxHeight = 180;
  $('#quickLinks').slimscroll({
    height: maxHeight+"px",
    alwaysVisible: true,
    size: '10px',
	railVisible: true,
	railColor: '#222',
	railOpacity: 0.3,
	wheelStep: 10,
	allowPageScroll: false,
	disableFadeOut: true
  });
});
</script>